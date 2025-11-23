def solve():
    s = input()
    vowels = "aeiouAEIOU"
    vowel_counts = {}
    consonant_counts = {}

    for char in s:
        if 'a' <= char <= 'z' or 'A' <= char <= 'Z':
            if char in vowels:
                vowel_counts[char] = vowel_counts.get(char, 0) + 1
            else:
                consonant_counts[char] = consonant_counts.get(char, 0) + 1

    most_frequent_vowel = None
    max_vowel_count = 0
    for vowel, count in vowel_counts.items():
        if count > max_vowel_count:
            max_vowel_count = count
            most_frequent_vowel = vowel
        elif count == max_vowel_count and vowel is not None and vowel < most_frequent_vowel:
            most_frequent_vowel = vowel

    most_frequent_consonant = None
    max_consonant_count = 0
    for consonant, count in consonant_counts.items():
        if count > max_consonant_count:
            max_consonant_count = count
            most_frequent_consonant = consonant
        elif count == max_consonant_count and consonant is not None and consonant < most_frequent_consonant:
            most_frequent_consonant = consonant

    if most_frequent_vowel is None:
        most_frequent_vowel = ""
    if most_frequent_consonant is None:
        most_frequent_consonant = ""

    print(most_frequent_vowel, most_frequent_consonant)

solve()