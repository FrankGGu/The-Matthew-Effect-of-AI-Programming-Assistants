class Solution:
    def sequenceReconstruction(self, org: List[int], seqs: List[List[int]]) -> bool:
        if not seqs:
            return False

        n = len(org)
        pos = [0] * (n + 1)
        for i, num in enumerate(org):
            pos[num] = i

        flags = [0] * (n + 1)
        for seq in seqs:
            for i in range(len(seq)):
                if seq[i] < 1 or seq[i] > n:
                    return False
                if i == 0:
                    continue
                pre, cur = seq[i-1], seq[i]
                if pos[pre] >= pos[cur]:
                    return False
                if flags[cur] < pos[pre] + 1:
                    flags[cur] = pos[pre] + 1

        for i in range(1, n + 1):
            if flags[i] != pos[i]:
                return False

        return True