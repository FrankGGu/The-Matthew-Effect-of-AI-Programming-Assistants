def solve():
    s = input()
    n = len(s)
    vowels = "AEIOUaeiou"
    vowel_counts = [0] * n
    vowel_counts[0] = 1 if s[0] in vowels else 0
    for i in range(1, n):
        vowel_counts[i] = vowel_counts[i - 1] + (1 if s[i] in vowels else 0)

    alice_score = 0
    bob_score = 0
    for i in range(n):
        if s[i] in vowels:
            alice_score += n - i
            bob_score += i + 1

    if alice_score > bob_score:
        print("Alice")
    elif alice_score < bob_score:
        print("Bob")
    else:
        print("Draw")

solve()