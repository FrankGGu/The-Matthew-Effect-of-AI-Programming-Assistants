class Solution:
    def complexNumberMultiply(self, num1: str, num2: str) -> str:
        def parse_complex(s: str):
            parts = s.split('+')
            real = int(parts[0])
            imag = int(parts[1][:-1])
            return real, imag

        r1, i1 = parse_complex(num1)
        r2, i2 = parse_complex(num2)

        result_real = r1 * r2 - i1 * i2
        result_imag = r1 * i2 + r2 * i1

        return f"{result_real}+{result_imag}i"