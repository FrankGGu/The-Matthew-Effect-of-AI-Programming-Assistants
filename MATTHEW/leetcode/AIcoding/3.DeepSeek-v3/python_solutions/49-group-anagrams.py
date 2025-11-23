class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        from collections import defaultdict
        anagram_dict = defaultdict(list)
        for s in strs:
            key = ''.join(sorted(s))
            anagram_dict[key].append(s)
        return list(anagram_dict.values())