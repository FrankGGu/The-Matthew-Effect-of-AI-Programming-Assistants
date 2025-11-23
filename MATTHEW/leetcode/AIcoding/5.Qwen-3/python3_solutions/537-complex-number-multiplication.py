class Solution:
    def complexNumberMultiply(self, a: str, b: str) -> str:
        def parse_complex(s: str):
            real, imag = s.split('+')
            return int(real), int(imag.replace('i', ''))

        real_a, imag_a = parse_complex(a)
        real_b, imag_b = parse_complex(b)

        real = real_a * real_b - imag_a * imag_b
        imag = real_a * imag_b + imag_a * real_b

        return f"{real}+{imag}i"