import pandas as pd

def solve():
    transactions = pd.DataFrame(Transactions)
    accounts = pd.DataFrame(Accounts)

    transaction_summary = transactions.groupby('account')['amount'].sum().reset_index()

    accounts_with_transaction = pd.merge(accounts, transaction_summary, left_on='account_id', right_on='account', how='left')

    accounts_with_transaction['amount'] = accounts_with_transaction['amount'].fillna(0)

    accounts_with_transaction['balance'] = accounts_with_transaction['balance'] + accounts_with_transaction['amount']

    filtered_accounts = accounts_with_transaction[accounts_with_transaction['balance'] > 1000]

    result = filtered_accounts[['name', 'balance']]

    return result

def bank_account_summary_ii(accounts: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    global Accounts, Transactions
    Accounts = accounts
    Transactions = transactions
    return solve()