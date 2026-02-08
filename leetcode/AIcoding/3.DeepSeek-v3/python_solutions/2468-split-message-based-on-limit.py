class Solution:
    def splitMessage(self, message: str, limit: int) -> List[str]:
        n = len(message)
        parts = 0
        found = False

        for k in range(1, n + 1):
            total = 0
            suffix_len = len(f"<{k}/{k}>")
            if suffix_len + 1 > limit:
                continue
            max_msg_len = limit * k
            for i in range(1, k + 1):
                part_suffix_len = len(f"<{i}/{k}>")
                max_msg_len -= part_suffix_len
            if max_msg_len >= n:
                parts = k
                found = True
                break

        if not found:
            return []

        res = []
        pos = 0
        for i in range(1, parts + 1):
            suffix = f"<{i}/{parts}>"
            remaining = limit - len(suffix)
            part = message[pos:pos + remaining] + suffix
            res.append(part)
            pos += remaining

        return res