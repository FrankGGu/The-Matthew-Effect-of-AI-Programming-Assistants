import pandas as pd

def get_dataframe_size(df: pd.DataFrame) -> list[int]:
    return list(df.shape)