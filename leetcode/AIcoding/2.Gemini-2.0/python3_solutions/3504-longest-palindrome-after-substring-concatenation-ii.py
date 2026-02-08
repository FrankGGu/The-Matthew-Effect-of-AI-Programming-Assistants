def longestPalindrome(words):
    count = {}
    for word in words:
        count[word] = count.get(word, 0) + 1

    ans = 0
    central = False
    for word in count:
        if word[0] < word[1]:
            continue
        if word[0] == word[1]:
            if count[word] % 2 == 0:
                ans += count[word]
            else:
                ans += count[word] - 1
                central = True
        else:
            rev = word[1] + word[0]
            if rev in count:
                ans += 2 * min(count[word], count[rev])

    if central:
        ans += 1

    return 2 * ans