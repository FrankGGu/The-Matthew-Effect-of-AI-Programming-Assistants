class Solution:
    def minimumTeachStudents(self, people: List[str]) -> int:
        from collections import Counter

        def get_freq(s):
            return Counter(s)

        def is_same_freq(f1, f2):
            return f1 == f2

        n = len(people)
        freqs = [get_freq(p) for p in people]
        res = 0

        for i in range(n):
            for j in range(i + 1, n):
                if is_same_freq(freqs[i], freqs[j]):
                    res += 1
                    break

        return res