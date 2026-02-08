class Solution:
    def splitMessage(self, message: str, limit: int) -> list[str]:
        n = len(message)
        k = 1
        while True:
            prefix_len = len(str(k))
            suffix_len = len(str(k))
            total_len = prefix_len + suffix_len + 3
            count = 0
            parts_possible = False

            l, r = k, 10 ** (len(str(k)))

            total_possible = 0
            for i in range(l, r):
                plen = len(str(i))
                slen = len(str(i))
                tlen = plen + slen + 3

                if limit - tlen >= 0:
                    total_possible += 1

            remaining = n

            can_split = True

            total_parts = 0

            l, r = 1, 10 ** (len(str(k)))

            for i in range(l, r):
                prefix_len = len(str(i))
                suffix_len = len(str(k))
                total_len = prefix_len + suffix_len + 3

                if limit - total_len >= 0:
                    total_parts += 1

            if k > 1:

                total_possible_chars = 0

                curr_k = 1

                while curr_k < k:
                    plen = len(str(curr_k))
                    slen = len(str(k))
                    tlen = plen + slen + 3

                    if limit - tlen >= 0:
                        total_possible_chars += limit - tlen
                    curr_k += 1

                plen = len(str(k))
                slen = len(str(k))
                tlen = plen + slen + 3

                if limit - tlen >= 0:
                    total_possible_chars += limit - tlen

                if total_possible_chars < n:
                    k += 1

                    continue
                else:

                    break

            else:

                plen = len(str(k))
                slen = len(str(k))
                tlen = plen + slen + 3

                if (limit - tlen) * total_parts < n:
                    k += 1

                    continue
                else:

                    break

        result = []
        start = 0
        for i in range(1, k + 1):
            prefix = str(i)
            suffix = str(k)
            total_len = len(prefix) + len(suffix) + 3

            available_len = limit - total_len

            result.append(message[start: start + available_len] + "<" + str(i) + "/" + str(k) + ">")
            start += available_len

        return result