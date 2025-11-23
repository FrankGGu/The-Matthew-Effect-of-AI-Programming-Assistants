import pandas as pd

def unique_subjects(teacher: pd.DataFrame) -> pd.DataFrame:
    teacher_grouped = teacher.groupby('teacher_id')['subject_id'].nunique().reset_index()
    teacher_grouped.rename(columns={'subject_id': 'cnt'}, inplace=True)
    return teacher_grouped