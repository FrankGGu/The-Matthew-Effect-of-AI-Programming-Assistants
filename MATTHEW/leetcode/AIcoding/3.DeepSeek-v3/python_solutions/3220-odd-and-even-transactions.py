import pandas as pd

def odd_and_even_transactions(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions['day'] = pd.to_datetime(transactions['day']).dt.day
    transactions['type'] = transactions['amount'].apply(lambda x: 'odd' if x % 2 != 0 else 'even')
    grouped = transactions.groupby(['account_id', 'type', 'day']).agg(count=('amount', 'count'), total_amount=('amount', 'sum')).reset_index()
    result = grouped[(grouped['count'] > 1) & (grouped['type'] == 'odd')]
    return result[['account_id', 'day', 'count', 'total_amount']].rename(columns={'total_amount': 'total'})