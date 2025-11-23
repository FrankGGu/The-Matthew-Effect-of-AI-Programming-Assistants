def count_substrings(s: str, k: int) -> int:
    n = len(s)
    count = 0
    vowels = set(['a', 'e', 'i', 'o', 'u'])

    for i in range(n):
        vowel_count = 0
        consonant_count = 0
        vowel_set = set()

        for j in range(i, n):
            if s[j] in vowels:
                vowel_count += 1
                vowel_set.add(s[j])
            else:
                consonant_count += 1

            if len(vowel_set) == 5 and consonant_count >= k:
                count += (n - j)

                break
    return count