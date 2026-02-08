import java.math.BigInteger;

class Solution {

    static class Fraction {
        BigInteger num;
        BigInteger den;

        public Fraction(BigInteger num, BigInteger den) {
            if (den.equals(BigInteger.ZERO)) {
                throw new IllegalArgumentException("Denominator cannot be zero.");
            }
            BigInteger common = num.gcd(den);
            this.num = num.divide(common);
            this.den = den.divide(common);

            if (this.den.compareTo(BigInteger.ZERO) < 0) {
                this.num = this.num.negate();
                this.den = this.den.negate();
            }
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Fraction fraction = (Fraction) o;
            return num.equals(fraction.num) && den.equals(fraction.den);
        }
    }

    private Fraction parseRationalFraction(String s) {
        int dotIndex = s.indexOf('.');
        int parenIndex = s.indexOf('(');

        if (dotIndex == -1) {
            return new Fraction(new BigInteger(s), BigInteger.ONE);
        }

        String integerPartStr = s.substring(0, dotIndex);
        BigInteger integerPart = new BigInteger(integerPartStr);

        if (parenIndex == -1) {
            String nonRepeatingPartStr = s.substring(dotIndex + 1);
            if (nonRepeatingPartStr.isEmpty()) {
                return new Fraction(integerPart, BigInteger.ONE);
            }

            BigInteger nonRepeatingVal = new BigInteger(nonRepeatingPartStr);
            BigInteger powerOfTen = BigInteger.TEN.pow(nonRepeatingPartStr.length());

            BigInteger num = integerPart.multiply(powerOfTen).add(nonRepeatingVal);
            BigInteger den = powerOfTen;
            return new Fraction(num, den);
        }

        String nonRepeatingPartStr = s.substring(dotIndex + 1, parenIndex);
        String repeatingPartStr = s.substring(parenIndex + 1, s.length() - 1);

        BigInteger X;
        BigInteger powerOfTen_LN;

        if (nonRepeatingPartStr.isEmpty()) {
            X = integerPart;
            powerOfTen_LN = BigInteger.ONE;
        } else {
            BigInteger nonRepeatingVal = new BigInteger(nonRepeatingPartStr);
            powerOfTen_LN = BigInteger.TEN.pow(nonRepeatingPartStr.length());
            X = integerPart.multiply(powerOfTen_LN).add(nonRepeatingVal);
        }

        BigInteger R_val = new BigInteger(repeatingPartStr);
        BigInteger powerOfTen_LR = BigInteger.TEN.pow(repeatingPartStr.length());
        BigInteger term_10LR_minus_1 = powerOfTen_LR.subtract(BigInteger.ONE);

        BigInteger finalNum = X.multiply(term_10LR_minus_1).add(R_val);
        BigInteger finalDen = powerOfTen_LN.multiply(term_10LR_minus_1);

        return new Fraction(finalNum, finalDen);
    }

    public boolean isRationalEqual(String S, String T) {
        Fraction f1 = parseRationalFraction(S);
        Fraction f2 = parseRationalFraction(T);
        return f1.equals(f2);
    }
}