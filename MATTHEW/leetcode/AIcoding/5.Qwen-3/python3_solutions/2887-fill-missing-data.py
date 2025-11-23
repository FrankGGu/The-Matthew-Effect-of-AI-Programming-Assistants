import pandas as pd

def fillMissingValues(df: pd.DataFrame) -> pd.DataFrame:
    df['product'] = df['product'].fillna('None')
    return df