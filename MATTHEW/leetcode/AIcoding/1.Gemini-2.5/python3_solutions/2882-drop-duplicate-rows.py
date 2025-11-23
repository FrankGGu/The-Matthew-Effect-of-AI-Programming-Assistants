import pandas as pd

def dropDuplicateRows(df: pd.DataFrame) -> pd.DataFrame:
    return df.drop_duplicates()