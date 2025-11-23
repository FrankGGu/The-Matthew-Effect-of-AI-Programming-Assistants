import pandas as pd

def changeDataTypes(students: pd.DataFrame) -> pd.DataFrame:
    students['age'] = students['age'].astype(int)
    students['weight'] = students['weight'].astype(float)
    return students