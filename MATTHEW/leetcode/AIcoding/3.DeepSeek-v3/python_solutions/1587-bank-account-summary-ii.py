import pandas as pd

def account_summary(users: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    merged = transactions.groupby('account').sum().reset_index()
    result = pd.merge(users, merged, on='account', how='inner')
    result = result[result['balance'] > 10000][['name', 'balance']]
    return result