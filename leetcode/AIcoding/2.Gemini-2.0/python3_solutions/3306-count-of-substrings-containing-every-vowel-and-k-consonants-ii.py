def count_substrings(s: str, k: int) -> int:
    n = len(s)
    count = 0
    vowels = "aeiou"

    for i in range(n):
        vowel_count = {v: 0 for v in vowels}
        consonant_count = 0
        for j in range(i, n):
            if s[j] in vowels:
                vowel_count[s[j]] += 1
            else:
                consonant_count += 1

            all_vowels_present = all(vowel_count[v] > 0 for v in vowels)

            if all_vowels_present and consonant_count >= k:
                count += (n - j)

                break # Optimization: Once we find a valid substring, all substrings starting at i and ending after j will also be valid, so we can break

    return count