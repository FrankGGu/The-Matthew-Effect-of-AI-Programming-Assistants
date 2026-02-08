from collections import Counter

def findSubstring(s: str, words: list[str]) -> list[int]:
    if not s or not words:
        return []

    word_len = len(words[0])
    total_len = word_len * len(words)
    result = []
    word_count = Counter(words)

    for i in range(len(s) - total_len + 1):
        seen_words = Counter()
        for j in range(len(words)):
            word_index = i + j * word_len
            word = s[word_index:word_index + word_len]
            if word in word_count:
                seen_words[word] += 1
                if seen_words[word] > word_count[word]:
                    break
            else:
                break
        else:
            if seen_words == word_count:
                result.append(i)

    return result