class Solution:
    def complexNumberMultiply(self, num1: str, num2: str) -> str:
        def parse_complex(num):
            parts = num.split('+')
            real = int(parts[0])
            imaginary = int(parts[1][:-1])
            return (real, imaginary)

        a, b = parse_complex(num1)
        c, d = parse_complex(num2)

        real_part = a * c - b * d
        imag_part = a * d + b * c

        return f"{real_part}+{imag_part}i"