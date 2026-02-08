class Solution:
    def digArtifacts(self, n: int, artifacts: List[List[int]], dig: List[List[int]]) -> int:
        dig_set = set((r, c) for r, c in dig)
        count = 0

        for artifact in artifacts:
            r1, c1, r2, c2 = artifact
            all_dug = True
            for r in range(r1, r2 + 1):
                for c in range(c1, c2 + 1):
                    if (r, c) not in dig_set:
                        all_dug = False
                        break
                if not all_dug:
                    break
            if all_dug:
                count += 1

        return count