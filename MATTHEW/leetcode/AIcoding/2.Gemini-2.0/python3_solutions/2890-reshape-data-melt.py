import pandas as pd

def melt_table(df: pd.DataFrame) -> pd.DataFrame:
    id_vars = ['product']
    value_vars = [col for col in df.columns if col != 'product']
    df_melted = pd.melt(df, id_vars=id_vars, value_vars=value_vars, var_name='quarter', value_name='price')
    return df_melted