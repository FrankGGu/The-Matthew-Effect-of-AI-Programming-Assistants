class Solution:
    def spellchecker(self, wordlist: List[str], queries: List[str]) -> List[str]:
        def devowel(word):
            return ''.join('*' if c in 'aeiou' else c for c in word)

        words = set(wordlist)
        vowels = {}
        consonants = {}

        for word in wordlist:
            key = devowel(word.lower())
            if key not in vowels:
                vowels[key] = word
            if word.lower() not in consonants:
                consonants[word.lower()] = word

        result = []
        for query in queries:
            lower = query.lower()
            key = devowel(lower)
            if query in words:
                result.append(query)
            elif lower in consonants:
                result.append(consonants[lower])
            elif key in vowels:
                result.append(vowels[key])
            else:
                result.append("")
        return result