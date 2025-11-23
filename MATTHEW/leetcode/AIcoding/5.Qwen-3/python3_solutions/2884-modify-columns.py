import pandas as pd

def modifyColumns(employees: pd.DataFrame) -> pd.DataFrame:
    employees['name'] = employees['name'].str.capitalize()
    employees['age'] = employees['age'] * 2
    return employees