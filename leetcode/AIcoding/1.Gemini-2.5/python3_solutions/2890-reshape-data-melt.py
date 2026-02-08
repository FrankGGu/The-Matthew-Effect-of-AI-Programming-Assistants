import pandas as pd
from typing import List

class Solution:
    def meltTable(self, df: pd.DataFrame) -> pd.DataFrame:
        id_column = df.columns[0]
        value_columns = df.columns[1:].tolist()

        melted_df = pd.melt(df, 
                            id_vars=[id_column], 
                            value_vars=value_columns, 
                            var_name='variable', 
                            value_name='value')

        return melted_df