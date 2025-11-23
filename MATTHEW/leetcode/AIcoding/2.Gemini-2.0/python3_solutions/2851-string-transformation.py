def solve():
    s = input()
    t = input()

    def is_transformable(s, t):
        if len(s) != len(t):
            return False

        n = len(s)

        mapping = {}
        used_t_chars = set()

        for i in range(n):
            s_char = s[i]
            t_char = t[i]

            if s_char not in mapping:
                if t_char in used_t_chars:
                    return False
                mapping[s_char] = t_char
                used_t_chars.add(t_char)
            else:
                if mapping[s_char] != t_char:
                    return False

        return True

    if is_transformable(s, t):
        print("Yes")
    else:
        print("No")

solve()