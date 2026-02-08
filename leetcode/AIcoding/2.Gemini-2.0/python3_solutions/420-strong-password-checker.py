class Solution:
    def strongPasswordChecker(self, password: str) -> int:
        n = len(password)
        missing = 0
        if not any(c.islower() for c in password):
            missing += 1
        if not any(c.isupper() for c in password):
            missing += 1
        if not any(c.isdigit() for c in password):
            missing += 1

        repeats = []
        i = 0
        while i < n:
            j = i
            while j < n and password[i] == password[j]:
                j += 1
            length = j - i
            if length >= 3:
                repeats.append(length)
            i = j

        changes = 0
        deletions = 0
        if n < 6:
            changes = max(missing, 6 - n)
        elif n > 20:
            diff = n - 20
            deletions = diff
            repeats.sort()
            for i in range(len(repeats)):
                if repeats[i] < 3:
                    continue
                decrement = min(diff, repeats[i] // 3)
                repeats[i] -= decrement
                diff -= decrement
                changes += decrement
                if diff == 0:
                    break
            if diff > 0:
                changes += diff

            changes = max(missing, changes)

        else:
            for length in repeats:
                changes += length // 3
            changes = max(missing, changes)

        return deletions + changes