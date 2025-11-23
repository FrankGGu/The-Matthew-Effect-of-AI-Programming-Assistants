import pandas as pd

def dropMissingData(customers: pd.DataFrame) -> pd.DataFrame:
    customers.dropna(subset=['email'], inplace=True)
    return customers