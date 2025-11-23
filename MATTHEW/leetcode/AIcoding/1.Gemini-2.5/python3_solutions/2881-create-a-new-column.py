import pandas as pd

def create_new_column(df: pd.DataFrame) -> pd.DataFrame:
    df['total_price'] = df['price'] * df['quantity']
    return df