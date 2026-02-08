class Solution:
    def largestVariance(self, s: str) -> int:
        chars = set(s)
        max_variance = 0
        for major in chars:
            for minor in chars:
                if major == minor:
                    continue
                major_count = 0
                minor_count = 0
                major_seen = False
                first_minor_idx = -1
                variance = 0
                for i, c in enumerate(s):
                    if c == major:
                        major_count += 1
                        major_seen = True
                    elif c == minor:
                        minor_count += 1
                        if first_minor_idx == -1:
                            first_minor_idx = i

                    if minor_count > 0 and major_seen:
                        variance = major_count - minor_count
                        max_variance = max(max_variance, variance)
                    elif minor_count > 0 and not major_seen and first_minor_idx != -1 and i > first_minor_idx:
                        pass

                    if minor_count > major_count:
                        major_count = 0
                        minor_count = 0
                        major_seen = False
                        first_minor_idx = -1

                major_count = 0
                minor_count = 0
                major_seen = False
                first_minor_idx = -1
                variance = 0

                for i in range(len(s) - 1, -1, -1):
                    c = s[i]
                    if c == major:
                        major_count += 1
                        major_seen = True
                    elif c == minor:
                        minor_count += 1
                        if first_minor_idx == -1:
                            first_minor_idx = i

                    if minor_count > 0 and major_seen:
                        variance = major_count - minor_count
                        max_variance = max(max_variance, variance)
                    elif minor_count > 0 and not major_seen and first_minor_idx != -1 and i < first_minor_idx:
                        pass

                    if minor_count > major_count:
                        major_count = 0
                        minor_count = 0
                        major_seen = False
                        first_minor_idx = -1

        return max_variance