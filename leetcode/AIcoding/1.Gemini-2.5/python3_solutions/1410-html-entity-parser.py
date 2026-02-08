class Solution:
    def entityParser(self, text: str) -> str:
        replacements = [
            ("&quot;", '"'),
            ("&apos;", "'"),
            ("&gt;", ">"),
            ("&lt;", "<"),
            ("&frasl;", "/"),
            ("&amp;", "&")
        ]

        # The order of replacements is crucial for correctness.
        # "&amp;" must be replaced last to prevent it from interfering with other entities.
        # For example, if "&amp;" were replaced first, "&quot;" would become "&quot;"
        # (if it was part of "&amp;quot;"), which is incorrect.
        # By replacing other entities first, we ensure they are correctly parsed.
        # Then, "&amp;" itself is replaced.

        # Note: This approach assumes non-recursive unescaping.
        # E.g., "&amp;quot;" will become "&amp;\"" then "&\"", not "\"".
        # And "&amp;amp;" will become "&amp;" then "&amp;", not "&".
        # This is typically the expected behavior for a single pass string replacement
        # in LeetCode problems when performance (O(N) vs O(N^2)) is a concern.

        for entity, char in replacements:
            text = text.replace(entity, char)

        return text