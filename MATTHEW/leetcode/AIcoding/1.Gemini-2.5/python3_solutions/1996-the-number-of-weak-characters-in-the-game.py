from typing import List

class Solution:
    def numberOfWeakCharacters(self, characters: List[List[int]]) -> int:
        # Sort characters:
        # Primary sort key: attack in descending order (-x[0])
        # Secondary sort key: defense in ascending order (x[1]) for ties
        # This sorting order is crucial:
        # 1. Processing characters with higher attack first ensures that
        #    when we consider a character (attack_i, defense_i),
        #    any character (attack_j, defense_j) processed before it either
        #    has attack_j > attack_i (making it a potential strong character)
        #    or attack_j == attack_i.
        # 2. For characters with the same attack value, sorting by defense in ascending order
        #    means we process (A, D1) before (A, D2) if D1 < D2.
        #    This prevents a character (A, D1) from incorrectly setting a high max_defense_so_far
        #    that would make (A, D2) seem weak (which is not allowed as attack_j is not > attack_i).
        characters.sort(key=lambda x: (-x[0], x[1]))

        weak_count = 0
        # max_defense_so_far stores the maximum defense encountered among characters
        # that have been processed and could potentially make subsequent characters weak.
        # Due to the sorting, this max_defense_so_far will always come from a character
        # with an attack value greater than or equal to the current character's attack.
        max_defense_so_far = 0

        for attack, defense in characters:
            # If the current character's defense is strictly less than the
            # maximum defense seen so far, it means there exists at least one
            # character (attack_j, defense_j) processed earlier such that:
            # 1. attack_j >= current_attack (due to primary sort order)
            # 2. defense_j = max_defense_so_far > current_defense
            #
            # The crucial part is to show that attack_j MUST be > current_attack.
            # If attack_j == current_attack, then defense_j must have been processed
            # before current_defense. Due to the secondary sort (defense ascending),
            # this would imply defense_j <= current_defense. But we have defense_j > current_defense.
            # This is a contradiction.
            # Therefore, max_defense_so_far must have come from a character with attack_j > current_attack.
            # Thus, the current character is weak.
            if defense < max_defense_so_far:
                weak_count += 1
            else:
                # This character is not weak by any character processed so far.
                # It might be a strong character itself, so update max_defense_so_far
                # to potentially set a new higher defense benchmark for subsequent characters
                # (which will have strictly lower attack values or higher defense in the same attack group).
                max_defense_so_far = defense

        return weak_count