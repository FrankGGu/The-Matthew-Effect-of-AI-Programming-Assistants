import pandas as pd

def selectData(students: pd.DataFrame) -> pd.DataFrame:
    return students[['name', 'age']]