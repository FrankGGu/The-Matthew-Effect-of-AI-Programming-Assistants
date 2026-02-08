import pandas as pd

class Solution:
    def dropMissingData(self, df: pd.DataFrame) -> pd.DataFrame:
        return df.dropna()