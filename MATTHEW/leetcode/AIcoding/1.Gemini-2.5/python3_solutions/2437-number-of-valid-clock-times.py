class Solution:
    def countTime(self, time: str) -> int:
        count = 0
        for h in range(24):
            for m in range(60):
                hh = str(h).zfill(2)
                mm = str(m).zfill(2)

                candidate_time = hh + ":" + mm

                is_match = True
                for i in range(5):
                    if time[i] != '?' and time[i] != candidate_time[i]:
                        is_match = False
                        break

                if is_match:
                    count += 1
        return count