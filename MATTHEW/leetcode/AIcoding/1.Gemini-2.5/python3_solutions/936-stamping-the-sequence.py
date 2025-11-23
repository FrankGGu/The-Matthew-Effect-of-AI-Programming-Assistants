import collections

class Solution:
    def stampingTheSequence(self, stamp: str, target: str) -> list[int]:
        N = len(target)
        M = len(stamp)

        target_list = list(target)

        q_count = 0 
        ans = [] 

        done_stamps = set() 
        possible_stamps = collections.deque()

        for i in range(N - M + 1):
            mismatches = 0
            non_q_count = 0 

            for k in range(M):
                if target_list[i + k] != '?':
                    non_q_count += 1
                    if target_list[i + k] != stamp[k]:
                        mismatches += 1
                        break

            if mismatches == 0 and non_q_count > 0:
                possible_stamps.append(i)

        while possible_stamps:
            idx = possible_stamps.popleft()

            if idx in done_stamps:
                continue

            ans.append(idx)
            done_stamps.add(idx)

            new_q_chars = 0
            for k in range(M):
                if target_list[idx + k] != '?':
                    target_list[idx + k] = '?'
                    new_q_chars += 1
            q_count += new_q_chars

            if q_count == N:
                break

            for j in range(max(0, idx - M + 1), min(N - M + 1, idx + M)):
                if j not in done_stamps:
                    mismatches = 0
                    non_q_count = 0

                    for k in range(M):
                        if target_list[j + k] != '?':
                            non_q_count += 1
                            if target_list[j + k] != stamp[k]:
                                mismatches += 1
                                break

                    if mismatches == 0 and non_q_count > 0:
                        possible_stamps.append(j)

        if q_count != N:
            return []

        return ans