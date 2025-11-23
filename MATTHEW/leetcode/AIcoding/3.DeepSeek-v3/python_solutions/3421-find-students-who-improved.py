import pandas as pd

def find_students_who_improved(scores: pd.DataFrame) -> pd.DataFrame:
    scores.sort_values(by=['student_id', 'test_date'], inplace=True)
    improved = []
    for student_id, group in scores.groupby('student_id'):
        if len(group) >= 2:
            first_score = group.iloc[0]['score']
            last_score = group.iloc[-1]['score']
            if last_score > first_score:
                improved.append(student_id)
    result = pd.DataFrame({'student_id': improved})
    result.sort_values(by='student_id', inplace=True)
    return result