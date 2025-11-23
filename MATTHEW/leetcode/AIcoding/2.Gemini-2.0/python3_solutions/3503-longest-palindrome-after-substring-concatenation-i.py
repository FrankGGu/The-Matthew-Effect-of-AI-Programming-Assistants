def longestPalindrome(words: list[str]) -> int:
    count = {}
    for word in words:
        count[word] = count.get(word, 0) + 1

    ans = 0
    central = False

    for word in count:
        if word[0] == word[1]:
            if count[word] % 2 == 0:
                ans += count[word]
            else:
                ans += count[word] - 1
                central = True
        elif word[0] < word[1] and word[::-1] in count:
            ans += 2 * min(count[word], count[word[::-1]])

    if central:
        ans += 1

    return 2 * ans