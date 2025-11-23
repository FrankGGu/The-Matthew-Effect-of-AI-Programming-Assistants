import pandas as pd

def get_size(df: pd.DataFrame) -> list:
    return [df.shape[0], df.shape[1]]