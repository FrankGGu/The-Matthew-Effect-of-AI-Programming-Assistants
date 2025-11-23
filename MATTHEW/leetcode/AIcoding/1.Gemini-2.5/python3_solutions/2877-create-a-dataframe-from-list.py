import pandas as pd
from typing import List

class Solution:
    def createDataFrame(self, data: List[List[int]], columns: List[str]) -> pd.DataFrame:
        return pd.DataFrame(data=data, columns=columns)