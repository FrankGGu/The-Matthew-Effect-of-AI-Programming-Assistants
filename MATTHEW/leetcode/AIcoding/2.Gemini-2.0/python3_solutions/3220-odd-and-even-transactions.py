import pandas as pd

def odd_and_even_transactions(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions['row_id'] = range(len(transactions))
    even_ids = transactions[transactions['transaction_id'] % 2 == 0]['amount'].idxmax()
    odd_ids = transactions[transactions['transaction_id'] % 2 != 0]['amount'].idxmax()

    even_transaction = transactions.loc[even_ids:even_ids] if not pd.isna(even_ids) else pd.DataFrame(columns=transactions.columns)
    odd_transaction = transactions.loc[odd_ids:odd_ids] if not pd.isna(odd_ids) else pd.DataFrame(columns=transactions.columns)

    result = pd.concat([odd_transaction, even_transaction], ignore_index=True)
    return result