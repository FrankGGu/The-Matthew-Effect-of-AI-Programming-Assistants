def extract_spell(s: str, spells: list[str]) -> str:
    """
    Given a string s and a list of strings spells, return the longest spell in spells that is a subsequence of s.
    If there are multiple spells with the same length, return the one that appears first in the list.
    If no spell is a subsequence of s, return an empty string.

    Example:
    extract_spell("abbcccddddeeeeffff", ["abc", "abcd", "abce", "abcde", "abcdef"]) == "abcde"
    extract_spell("abbcccddddeeeeffff", ["abc", "abcd", "abce", "abcde", "abcdefg"]) == "abcde"
    extract_spell("abbcccddddeeeeffff", ["abcdefg", "abcdef", "abcde", "abcd", "abce", "abc"]) == "abcdef"

    Args:
        s: The string to search in.
        spells: The list of spells to search for.

    Returns:
        The longest spell in spells that is a subsequence of s.
    """

    longest_spell = ""
    for spell in spells:
        i = 0
        j = 0
        while i < len(s) and j < len(spell):
            if s[i] == spell[j]:
                j += 1
            i += 1
        if j == len(spell):
            if len(spell) > len(longest_spell):
                longest_spell = spell
    return longest_spell