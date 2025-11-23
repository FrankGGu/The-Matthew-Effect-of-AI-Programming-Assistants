class Solution:
    def uniqueSubjects(self, subjects: List[List[str]]) -> List[int]:
        subject_set = {}
        for teacher, subject in subjects:
            if teacher not in subject_set:
                subject_set[teacher] = set()
            subject_set[teacher].add(subject)
        return [len(subject_set[teacher]) for teacher in subject_set]