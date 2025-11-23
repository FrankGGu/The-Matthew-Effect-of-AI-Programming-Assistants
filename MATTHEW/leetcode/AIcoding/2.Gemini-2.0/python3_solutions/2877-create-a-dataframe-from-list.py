import pandas as pd

def createDataframe(student_data: list[list[int | str]]) -> pd.DataFrame:
    df = pd.DataFrame(student_data, columns=['student_id', 'name', 'age'])
    return df