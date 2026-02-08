def repeatLimitedString(self, s: str, repeatLimit: int) -> str:
    from collections import Counter
    count = Counter(s)
    result = []

    while count:
        max_char = max(count)
        if result and result[-1] == max_char:
            if len(count) == 1:
                break
            next_char = max(c for c in count if c != max_char)
            result.append(next_char)
            count[next_char] -= 1
            if count[next_char] == 0:
                del count[next_char]
            result.append(max_char)
            count[max_char] -= 1
            if count[max_char] == 0:
                del count[max_char]
        else:
            take = min(count[max_char], repeatLimit)
            result.append(max_char * take)
            count[max_char] -= take
            if count[max_char] == 0:
                del count[max_char]

    return ''.join(result)