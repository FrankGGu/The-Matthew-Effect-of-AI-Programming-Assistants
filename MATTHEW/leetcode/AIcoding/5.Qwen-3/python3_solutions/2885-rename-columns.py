import pandas as pd

def renameColumns(employees: pd.DataFrame) -> pd.DataFrame:
    employees.rename(columns={'name': 'student_name', 'id': 'student_id', 'age': 'student_age'}, inplace=True)
    return employees