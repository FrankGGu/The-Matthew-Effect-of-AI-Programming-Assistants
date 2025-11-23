class Solution:
    def complexNumberMultiply(self, num1: str, num2: str) -> str:
        def parse_complex(num: str) -> tuple[int, int]:
            real, imag = num.split('+')
            imag = imag[:-1]
            return int(real), int(imag)

        real1, imag1 = parse_complex(num1)
        real2, imag2 = parse_complex(num2)

        real_part = real1 * real2 - imag1 * imag2
        imag_part = real1 * imag2 + real2 * imag1

        return f"{real_part}+{imag_part}i"