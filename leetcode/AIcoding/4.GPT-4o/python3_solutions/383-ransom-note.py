def canConstruct(ransomNote: str, magazine: str) -> bool:
    from collections import Counter
    return not (Counter(ransomNote) - Counter(magazine))