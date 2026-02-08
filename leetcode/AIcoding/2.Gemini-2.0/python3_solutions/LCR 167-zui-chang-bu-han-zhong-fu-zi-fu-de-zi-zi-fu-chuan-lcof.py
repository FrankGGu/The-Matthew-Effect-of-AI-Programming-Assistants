def disassemble_attack(attack: str) -> list[str]:
    result = []
    i = 0
    while i < len(attack):
        j = i + 1
        while j < len(attack) and attack[j].isdigit():
            j += 1
        result.append(attack[i:j])
        i = j
    return result