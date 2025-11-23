import pandas as pd

def findStudents(students: pd.DataFrame, examinations: pd.DataFrame) -> pd.DataFrame:
    df = pd.merge(examinations, students, on='student_id', how='left')
    df = df.groupby('student_id').agg({'score': ['sum', 'count']})
    df.columns = ['total_score', 'num_exams']
    df['avg_score'] = df['total_score'] / df['num_exams']

    first_exam = examinations.groupby('student_id').first().reset_index()

    merged = pd.merge(df.reset_index(), first_exam, on='student_id', how='left')

    improved_students = merged[merged['total_score'] / merged['num_exams'] > merged['score']].copy()

    improved_students = improved_students[['student_id']].rename(columns={'student_id': 'student_id'})

    return improved_students