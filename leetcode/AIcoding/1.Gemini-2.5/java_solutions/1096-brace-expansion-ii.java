import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

class Solution {

    private char[] sChars;
    private int[] ptr; // Pointer to current position in sChars

    public List<String> braceExpansionII(String expression) {
        sChars = expression.toCharArray();
        ptr = new int[]{0};

        Set<String> result = parseExpression();

        // TreeSet already ensures sorted and unique, so just convert to List
        return new ArrayList<>(result);
    }

    // Parses an expression, which is a union of terms: term (',' term)*
    private Set<String> parseExpression() {
        Set<String> result = new TreeSet<>();

        result.addAll(parseTerm()); // Parse the first term

        // Handle union operations
        while (ptr[0] < sChars.length && sChars[ptr[0]] == ',') {
            ptr[0]++; // Consume ','
            result.addAll(parseTerm()); // Union with subsequent terms
        }

        return result;
    }

    // Parses a term, which is a concatenation of factors: factor*
    private Set<String> parseTerm() {
        Set<String> currentTermWords = null; // Represents the words accumulated for the current term

        // Loop while we encounter factors that are part of this term (not ',' or '}')
        while (ptr[0] < sChars.length && sChars[ptr[0]] != ',' && sChars[ptr[0]] != '}') {
            Set<String> factorWords = parseFactor();

            if (currentTermWords == null) {
                // This is the first factor in the term
                currentTermWords = factorWords;
            } else {
                // Concatenate currentTermWords with factorWords (Cartesian product)
                Set<String> newTermWords = new TreeSet<>();
                for (String currentWord : currentTermWords) {
                    for (String factorWord : factorWords) {
                        newTermWords.add(currentWord + factorWord);
                    }
                }
                currentTermWords = newTermWords;
            }
        }

        // If no factors were found for this term (e.g., for "{}"), return an empty set.
        // Otherwise, return the accumulated words.
        return currentTermWords == null ? new TreeSet<>() : currentTermWords;
    }

    // Parses a factor, which is either a single letter or an expression in braces: LETTER | '{' expression '}'
    private Set<String> parseFactor() {
        Set<String> result = new TreeSet<>();

        if (sChars[ptr[0]] == '{') {
            ptr[0]++; // Consume '{'
            result.addAll(parseExpression()); // Recursively parse the nested expression
            ptr[0]++; // Consume '}'
        } else {
            // It's a single lowercase letter
            result.add(String.valueOf(sChars[ptr[0]]));
            ptr[0]++; // Consume the letter
        }

        return result;
    }
}