import heapq

class Solution:
    def minimizeStringValue(self, s: str) -> str:
        freq = [0] * 26
        for c in s:
            if c != '?':
                freq[ord(c) - ord('a')] += 1

        heap = []
        for i in range(26):
            heapq.heappush(heap, (freq[i], chr(ord('a') + i)))

        replace_chars = []
        for c in s:
            if c == '?':
                count, char = heapq.heappop(heap)
                replace_chars.append(char)
                heapq.heappush(heap, (count + 1, char))

        replace_chars.sort()
        res = []
        replace_idx = 0
        for c in s:
            if c == '?':
                res.append(replace_chars[replace_idx])
                replace_idx += 1
            else:
                res.append(c)

        return ''.join(res)