import pandas as pd

def renameColumns(employees: pd.DataFrame) -> pd.DataFrame:
    employees.rename(columns={'id': 'employeeId'}, inplace=True)
    return employees