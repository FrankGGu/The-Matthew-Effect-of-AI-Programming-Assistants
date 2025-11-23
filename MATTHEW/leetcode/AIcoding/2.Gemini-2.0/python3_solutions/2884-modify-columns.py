import pandas as pd

def modify_columns(customers: pd.DataFrame) -> pd.DataFrame:
    customers['name'] = customers['name'].str.upper()
    return customers