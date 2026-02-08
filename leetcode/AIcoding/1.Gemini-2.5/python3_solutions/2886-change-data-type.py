import pandas as pd

def changeDatatype(employees: pd.DataFrame) -> pd.DataFrame:
    employees['salary'] = employees['salary'].astype(int)
    return employees