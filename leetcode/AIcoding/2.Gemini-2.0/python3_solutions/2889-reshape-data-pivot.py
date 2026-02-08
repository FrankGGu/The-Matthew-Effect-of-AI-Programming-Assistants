import pandas as pd

def pivot_longer(df: pd.DataFrame, column: str, values_to: str) -> pd.DataFrame:
    df_melted = df.melt(id_vars=['id'], value_vars=[col for col in df.columns if col != 'id'], var_name=column, value_name=values_to)
    return df_melted