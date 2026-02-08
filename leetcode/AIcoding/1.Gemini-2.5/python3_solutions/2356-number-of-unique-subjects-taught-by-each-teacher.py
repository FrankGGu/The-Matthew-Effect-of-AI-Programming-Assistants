import pandas as pd

def unique_subjects_taught_by_each_teacher(teachers: pd.DataFrame) -> pd.DataFrame:
    result = teachers.groupby('teacher_id')['subject_id'].nunique().reset_index()
    result.columns = ['teacher_id', 'cnt']
    return result